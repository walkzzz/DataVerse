///===
/// extcore/timeseries_sarima

pub(all) struct TimeseriessarimaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_sarima_make_point(x : Double, y : Double) -> TimeseriessarimaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_sarima_make_point3(x : Double, y : Double, z : Double) -> TimeseriessarimaPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriessarimaPoint::x(self : TimeseriessarimaPoint) -> Double { self.x }

pub fn TimeseriessarimaPoint::y(self : TimeseriessarimaPoint) -> Double { self.y }

pub fn TimeseriessarimaPoint::z(self : TimeseriessarimaPoint) -> Double { self.z }

pub fn TimeseriessarimaPoint::label(self : TimeseriessarimaPoint) -> Int { self.label }

pub fn TimeseriessarimaPoint::dist(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriessarimaPoint::add(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriessarimaPoint::sub(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriessarimaPoint::scale(self : TimeseriessarimaPoint, s : Double) -> TimeseriessarimaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriessarimaPoint::dot(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriessarimaPoint::cross(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriessarimaPoint::norm(self : TimeseriessarimaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriessarimaPoint::normalize(self : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriessarimaPoint::negate(self : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriessarimaPoint::mid(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriessarimaPoint::lerp(self : TimeseriessarimaPoint, other : TimeseriessarimaPoint, t : Double) -> TimeseriessarimaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriessarimaPoint::to_string(self : TimeseriessarimaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriessarimaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_sarima_make_series(vals : Array[Double], name : String) -> TimeseriessarimaSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriessarimaSeries::len(self : TimeseriessarimaSeries) -> Int { self.vals.length() }

pub fn TimeseriessarimaSeries::sum(self : TimeseriessarimaSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriessarimaSeries::mean(self : TimeseriessarimaSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriessarimaSeries::min(self : TimeseriessarimaSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriessarimaSeries::max(self : TimeseriessarimaSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriessarimaSeries::range(self : TimeseriessarimaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriessarimaSeries::variance(self : TimeseriessarimaSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriessarimaSeries::std(self : TimeseriessarimaSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriessarimaSeries::median(self : TimeseriessarimaSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriessarimaSeries::scale(self : TimeseriessarimaSeries, f : Double) -> TimeseriessarimaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::add(self : TimeseriessarimaSeries, other : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::sub(self : TimeseriessarimaSeries, other : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriessarimaSeries::normalize(self : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriessarimaSeries::cumsum(self : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriessarimaSeries::to_string(self : TimeseriessarimaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriessarimaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_sarima_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriessarimaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_sarima_matrix_identity(n : Int) -> TimeseriessarimaMatrix {
  let m = timeseries_sarima_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriessarimaMatrix::get(self : TimeseriessarimaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriessarimaMatrix::transpose(self : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriessarimaMatrix::add(self : TimeseriessarimaMatrix, other : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_sarima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriessarimaMatrix::scale(self : TimeseriessarimaMatrix, s : Double) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriessarimaMatrix::multiply(self : TimeseriessarimaMatrix, other : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if self.cols != other.rows { return timeseries_sarima_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_sarima_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriessarimaMatrix::trace(self : TimeseriessarimaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriessarimaMatrix::det(self : TimeseriessarimaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriessarimaMatrix::norm(self : TimeseriessarimaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriessarimaMatrix::to_string(self : TimeseriessarimaMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriessarimaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_sarima_make_vector(comps : Array[Double]) -> TimeseriessarimaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_sarima_vector_zero(dim : Int) -> TimeseriessarimaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriessarimaVector::add(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriessarimaVector::sub(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriessarimaVector::scale(self : TimeseriessarimaVector, s : Double) -> TimeseriessarimaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriessarimaVector::dot(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriessarimaVector::norm(self : TimeseriessarimaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriessarimaVector::normalize(self : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriessarimaVector::dist(self : TimeseriessarimaVector, other : TimeseriessarimaVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriessarimaVector::to_string(self : TimeseriessarimaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriessarimaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_frame_make(size : Int) -> TimeseriessarimaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaFrame::len(self : TimeseriessarimaFrame) -> Int { self.size }

pub fn TimeseriessarimaFrame::get(self : TimeseriessarimaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaFrame::set(self : TimeseriessarimaFrame, i : Int, v : Double) -> TimeseriessarimaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaFrame::sum(self : TimeseriessarimaFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaFrame::mean(self : TimeseriessarimaFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaFrame::scale(self : TimeseriessarimaFrame, f : Double) -> TimeseriessarimaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaFrame::add(self : TimeseriessarimaFrame, other : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaFrame::copy(self : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaFrame::fill(self : TimeseriessarimaFrame, v : Double) -> TimeseriessarimaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaFrame::min(self : TimeseriessarimaFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaFrame::max(self : TimeseriessarimaFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaFrame::to_string(self : TimeseriessarimaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_table_make(size : Int) -> TimeseriessarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaTable::len(self : TimeseriessarimaTable) -> Int { self.size }

pub fn TimeseriessarimaTable::get(self : TimeseriessarimaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaTable::set(self : TimeseriessarimaTable, i : Int, v : Double) -> TimeseriessarimaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaTable::sum(self : TimeseriessarimaTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaTable::mean(self : TimeseriessarimaTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaTable::scale(self : TimeseriessarimaTable, f : Double) -> TimeseriessarimaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaTable::add(self : TimeseriessarimaTable, other : TimeseriessarimaTable) -> TimeseriessarimaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaTable::copy(self : TimeseriessarimaTable) -> TimeseriessarimaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaTable::fill(self : TimeseriessarimaTable, v : Double) -> TimeseriessarimaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaTable::min(self : TimeseriessarimaTable) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaTable::max(self : TimeseriessarimaTable) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaTable::to_string(self : TimeseriessarimaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_graphn_make(size : Int) -> TimeseriessarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaGraphN::len(self : TimeseriessarimaGraphN) -> Int { self.size }

pub fn TimeseriessarimaGraphN::get(self : TimeseriessarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaGraphN::set(self : TimeseriessarimaGraphN, i : Int, v : Double) -> TimeseriessarimaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaGraphN::sum(self : TimeseriessarimaGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaGraphN::mean(self : TimeseriessarimaGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaGraphN::scale(self : TimeseriessarimaGraphN, f : Double) -> TimeseriessarimaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaGraphN::add(self : TimeseriessarimaGraphN, other : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaGraphN::copy(self : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaGraphN::fill(self : TimeseriessarimaGraphN, v : Double) -> TimeseriessarimaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaGraphN::min(self : TimeseriessarimaGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaGraphN::max(self : TimeseriessarimaGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaGraphN::to_string(self : TimeseriessarimaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_node_make(size : Int) -> TimeseriessarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaNode::len(self : TimeseriessarimaNode) -> Int { self.size }

pub fn TimeseriessarimaNode::get(self : TimeseriessarimaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaNode::set(self : TimeseriessarimaNode, i : Int, v : Double) -> TimeseriessarimaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaNode::sum(self : TimeseriessarimaNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaNode::mean(self : TimeseriessarimaNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaNode::scale(self : TimeseriessarimaNode, f : Double) -> TimeseriessarimaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaNode::add(self : TimeseriessarimaNode, other : TimeseriessarimaNode) -> TimeseriessarimaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaNode::copy(self : TimeseriessarimaNode) -> TimeseriessarimaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaNode::fill(self : TimeseriessarimaNode, v : Double) -> TimeseriessarimaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaNode::min(self : TimeseriessarimaNode) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaNode::max(self : TimeseriessarimaNode) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaNode::to_string(self : TimeseriessarimaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_edge_make(size : Int) -> TimeseriessarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaEdge::len(self : TimeseriessarimaEdge) -> Int { self.size }

pub fn TimeseriessarimaEdge::get(self : TimeseriessarimaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaEdge::set(self : TimeseriessarimaEdge, i : Int, v : Double) -> TimeseriessarimaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaEdge::sum(self : TimeseriessarimaEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaEdge::mean(self : TimeseriessarimaEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaEdge::scale(self : TimeseriessarimaEdge, f : Double) -> TimeseriessarimaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaEdge::add(self : TimeseriessarimaEdge, other : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaEdge::copy(self : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaEdge::fill(self : TimeseriessarimaEdge, v : Double) -> TimeseriessarimaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaEdge::min(self : TimeseriessarimaEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaEdge::max(self : TimeseriessarimaEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaEdge::to_string(self : TimeseriessarimaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_path_make(size : Int) -> TimeseriessarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaPath::len(self : TimeseriessarimaPath) -> Int { self.size }

pub fn TimeseriessarimaPath::get(self : TimeseriessarimaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaPath::set(self : TimeseriessarimaPath, i : Int, v : Double) -> TimeseriessarimaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaPath::sum(self : TimeseriessarimaPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaPath::mean(self : TimeseriessarimaPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaPath::scale(self : TimeseriessarimaPath, f : Double) -> TimeseriessarimaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaPath::add(self : TimeseriessarimaPath, other : TimeseriessarimaPath) -> TimeseriessarimaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaPath::copy(self : TimeseriessarimaPath) -> TimeseriessarimaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaPath::fill(self : TimeseriessarimaPath, v : Double) -> TimeseriessarimaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaPath::min(self : TimeseriessarimaPath) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaPath::max(self : TimeseriessarimaPath) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaPath::to_string(self : TimeseriessarimaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cluster_make(size : Int) -> TimeseriessarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaCluster::len(self : TimeseriessarimaCluster) -> Int { self.size }

pub fn TimeseriessarimaCluster::get(self : TimeseriessarimaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaCluster::set(self : TimeseriessarimaCluster, i : Int, v : Double) -> TimeseriessarimaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCluster::sum(self : TimeseriessarimaCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaCluster::mean(self : TimeseriessarimaCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaCluster::scale(self : TimeseriessarimaCluster, f : Double) -> TimeseriessarimaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCluster::add(self : TimeseriessarimaCluster, other : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaCluster::copy(self : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCluster::fill(self : TimeseriessarimaCluster, v : Double) -> TimeseriessarimaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCluster::min(self : TimeseriessarimaCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaCluster::max(self : TimeseriessarimaCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaCluster::to_string(self : TimeseriessarimaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_model_make(size : Int) -> TimeseriessarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaModel::len(self : TimeseriessarimaModel) -> Int { self.size }

pub fn TimeseriessarimaModel::get(self : TimeseriessarimaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaModel::set(self : TimeseriessarimaModel, i : Int, v : Double) -> TimeseriessarimaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaModel::sum(self : TimeseriessarimaModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaModel::mean(self : TimeseriessarimaModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaModel::scale(self : TimeseriessarimaModel, f : Double) -> TimeseriessarimaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaModel::add(self : TimeseriessarimaModel, other : TimeseriessarimaModel) -> TimeseriessarimaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaModel::copy(self : TimeseriessarimaModel) -> TimeseriessarimaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaModel::fill(self : TimeseriessarimaModel, v : Double) -> TimeseriessarimaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaModel::min(self : TimeseriessarimaModel) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaModel::max(self : TimeseriessarimaModel) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaModel::to_string(self : TimeseriessarimaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_layer_make(size : Int) -> TimeseriessarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaLayer::len(self : TimeseriessarimaLayer) -> Int { self.size }

pub fn TimeseriessarimaLayer::get(self : TimeseriessarimaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaLayer::set(self : TimeseriessarimaLayer, i : Int, v : Double) -> TimeseriessarimaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaLayer::sum(self : TimeseriessarimaLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaLayer::mean(self : TimeseriessarimaLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaLayer::scale(self : TimeseriessarimaLayer, f : Double) -> TimeseriessarimaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaLayer::add(self : TimeseriessarimaLayer, other : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaLayer::copy(self : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaLayer::fill(self : TimeseriessarimaLayer, v : Double) -> TimeseriessarimaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaLayer::min(self : TimeseriessarimaLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaLayer::max(self : TimeseriessarimaLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaLayer::to_string(self : TimeseriessarimaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_buffer_make(size : Int) -> TimeseriessarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaBuffer::len(self : TimeseriessarimaBuffer) -> Int { self.size }

pub fn TimeseriessarimaBuffer::get(self : TimeseriessarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaBuffer::set(self : TimeseriessarimaBuffer, i : Int, v : Double) -> TimeseriessarimaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaBuffer::sum(self : TimeseriessarimaBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaBuffer::mean(self : TimeseriessarimaBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaBuffer::scale(self : TimeseriessarimaBuffer, f : Double) -> TimeseriessarimaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaBuffer::add(self : TimeseriessarimaBuffer, other : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaBuffer::copy(self : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaBuffer::fill(self : TimeseriessarimaBuffer, v : Double) -> TimeseriessarimaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaBuffer::min(self : TimeseriessarimaBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaBuffer::max(self : TimeseriessarimaBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaBuffer::to_string(self : TimeseriessarimaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cursor_make(size : Int) -> TimeseriessarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaCursor::len(self : TimeseriessarimaCursor) -> Int { self.size }

pub fn TimeseriessarimaCursor::get(self : TimeseriessarimaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaCursor::set(self : TimeseriessarimaCursor, i : Int, v : Double) -> TimeseriessarimaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCursor::sum(self : TimeseriessarimaCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaCursor::mean(self : TimeseriessarimaCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaCursor::scale(self : TimeseriessarimaCursor, f : Double) -> TimeseriessarimaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCursor::add(self : TimeseriessarimaCursor, other : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaCursor::copy(self : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCursor::fill(self : TimeseriessarimaCursor, v : Double) -> TimeseriessarimaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaCursor::min(self : TimeseriessarimaCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaCursor::max(self : TimeseriessarimaCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaCursor::to_string(self : TimeseriessarimaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_view_make(size : Int) -> TimeseriessarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaView::len(self : TimeseriessarimaView) -> Int { self.size }

pub fn TimeseriessarimaView::get(self : TimeseriessarimaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaView::set(self : TimeseriessarimaView, i : Int, v : Double) -> TimeseriessarimaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaView::sum(self : TimeseriessarimaView) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaView::mean(self : TimeseriessarimaView) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaView::scale(self : TimeseriessarimaView, f : Double) -> TimeseriessarimaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaView::add(self : TimeseriessarimaView, other : TimeseriessarimaView) -> TimeseriessarimaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaView::copy(self : TimeseriessarimaView) -> TimeseriessarimaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaView::fill(self : TimeseriessarimaView, v : Double) -> TimeseriessarimaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaView::min(self : TimeseriessarimaView) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaView::max(self : TimeseriessarimaView) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaView::to_string(self : TimeseriessarimaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_range_make(size : Int) -> TimeseriessarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaRange::len(self : TimeseriessarimaRange) -> Int { self.size }

pub fn TimeseriessarimaRange::get(self : TimeseriessarimaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaRange::set(self : TimeseriessarimaRange, i : Int, v : Double) -> TimeseriessarimaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaRange::sum(self : TimeseriessarimaRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaRange::mean(self : TimeseriessarimaRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaRange::scale(self : TimeseriessarimaRange, f : Double) -> TimeseriessarimaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaRange::add(self : TimeseriessarimaRange, other : TimeseriessarimaRange) -> TimeseriessarimaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaRange::copy(self : TimeseriessarimaRange) -> TimeseriessarimaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaRange::fill(self : TimeseriessarimaRange, v : Double) -> TimeseriessarimaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaRange::min(self : TimeseriessarimaRange) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaRange::max(self : TimeseriessarimaRange) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaRange::to_string(self : TimeseriessarimaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_slice_make(size : Int) -> TimeseriessarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriessarimaSlice::len(self : TimeseriessarimaSlice) -> Int { self.size }

pub fn TimeseriessarimaSlice::get(self : TimeseriessarimaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriessarimaSlice::set(self : TimeseriessarimaSlice, i : Int, v : Double) -> TimeseriessarimaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaSlice::sum(self : TimeseriessarimaSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriessarimaSlice::mean(self : TimeseriessarimaSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriessarimaSlice::scale(self : TimeseriessarimaSlice, f : Double) -> TimeseriessarimaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaSlice::add(self : TimeseriessarimaSlice, other : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriessarimaSlice::copy(self : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaSlice::fill(self : TimeseriessarimaSlice, v : Double) -> TimeseriessarimaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriessarimaSlice::min(self : TimeseriessarimaSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriessarimaSlice::max(self : TimeseriessarimaSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriessarimaSlice::to_string(self : TimeseriessarimaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

