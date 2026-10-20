///===
/// extcore/timeseries_forecast_deepar

pub(all) struct TimeseriesforecastdeeparPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_deepar_make_point(x : Double, y : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_deepar_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdeeparPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastdeeparPoint::x(self : TimeseriesforecastdeeparPoint) -> Double { self.x }

pub fn TimeseriesforecastdeeparPoint::y(self : TimeseriesforecastdeeparPoint) -> Double { self.y }

pub fn TimeseriesforecastdeeparPoint::z(self : TimeseriesforecastdeeparPoint) -> Double { self.z }

pub fn TimeseriesforecastdeeparPoint::label(self : TimeseriesforecastdeeparPoint) -> Int { self.label }

pub fn TimeseriesforecastdeeparPoint::dist(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastdeeparPoint::add(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::sub(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::scale(self : TimeseriesforecastdeeparPoint, s : Double) -> TimeseriesforecastdeeparPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::dot(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastdeeparPoint::cross(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastdeeparPoint::norm(self : TimeseriesforecastdeeparPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastdeeparPoint::normalize(self : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdeeparPoint::negate(self : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::mid(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint) -> TimeseriesforecastdeeparPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::lerp(self : TimeseriesforecastdeeparPoint, other : TimeseriesforecastdeeparPoint, t : Double) -> TimeseriesforecastdeeparPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastdeeparPoint::to_string(self : TimeseriesforecastdeeparPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_deepar_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdeeparSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastdeeparSeries::len(self : TimeseriesforecastdeeparSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastdeeparSeries::sum(self : TimeseriesforecastdeeparSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastdeeparSeries::mean(self : TimeseriesforecastdeeparSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastdeeparSeries::min(self : TimeseriesforecastdeeparSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastdeeparSeries::max(self : TimeseriesforecastdeeparSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastdeeparSeries::range(self : TimeseriesforecastdeeparSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastdeeparSeries::variance(self : TimeseriesforecastdeeparSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastdeeparSeries::std(self : TimeseriesforecastdeeparSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastdeeparSeries::median(self : TimeseriesforecastdeeparSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastdeeparSeries::scale(self : TimeseriesforecastdeeparSeries, f : Double) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::add(self : TimeseriesforecastdeeparSeries, other : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::sub(self : TimeseriesforecastdeeparSeries, other : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::normalize(self : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastdeeparSeries::cumsum(self : TimeseriesforecastdeeparSeries) -> TimeseriesforecastdeeparSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastdeeparSeries::to_string(self : TimeseriesforecastdeeparSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdeeparMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_deepar_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdeeparMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_forecast_deepar_matrix_identity(n : Int) -> TimeseriesforecastdeeparMatrix {
  let m = timeseries_forecast_deepar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastdeeparMatrix::get(self : TimeseriesforecastdeeparMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastdeeparMatrix::transpose(self : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::add(self : TimeseriesforecastdeeparMatrix, other : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_deepar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::scale(self : TimeseriesforecastdeeparMatrix, s : Double) -> TimeseriesforecastdeeparMatrix {
  let result = timeseries_forecast_deepar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastdeeparMatrix::multiply(self : TimeseriesforecastdeeparMatrix, other : TimeseriesforecastdeeparMatrix) -> TimeseriesforecastdeeparMatrix {
  if self.cols != other.rows { return timeseries_forecast_deepar_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_deepar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesforecastdeeparMatrix::trace(self : TimeseriesforecastdeeparMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastdeeparMatrix::det(self : TimeseriesforecastdeeparMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastdeeparMatrix::norm(self : TimeseriesforecastdeeparMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastdeeparMatrix::to_string(self : TimeseriesforecastdeeparMatrix) -> String {
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

pub(all) struct TimeseriesforecastdeeparVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_deepar_make_vector(comps : Array[Double]) -> TimeseriesforecastdeeparVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_deepar_vector_zero(dim : Int) -> TimeseriesforecastdeeparVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastdeeparVector::add(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdeeparVector::sub(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdeeparVector::scale(self : TimeseriesforecastdeeparVector, s : Double) -> TimeseriesforecastdeeparVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastdeeparVector::dot(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastdeeparVector::norm(self : TimeseriesforecastdeeparVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastdeeparVector::normalize(self : TimeseriesforecastdeeparVector) -> TimeseriesforecastdeeparVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdeeparVector::dist(self : TimeseriesforecastdeeparVector, other : TimeseriesforecastdeeparVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastdeeparVector::to_string(self : TimeseriesforecastdeeparVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdeeparFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_frame_make(size : Int) -> TimeseriesforecastdeeparFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparFrame::len(self : TimeseriesforecastdeeparFrame) -> Int { self.size }

pub fn TimeseriesforecastdeeparFrame::get(self : TimeseriesforecastdeeparFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparFrame::set(self : TimeseriesforecastdeeparFrame, i : Int, v : Double) -> TimeseriesforecastdeeparFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparFrame::sum(self : TimeseriesforecastdeeparFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparFrame::mean(self : TimeseriesforecastdeeparFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparFrame::scale(self : TimeseriesforecastdeeparFrame, f : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparFrame::add(self : TimeseriesforecastdeeparFrame, other : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparFrame::copy(self : TimeseriesforecastdeeparFrame) -> TimeseriesforecastdeeparFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparFrame::fill(self : TimeseriesforecastdeeparFrame, v : Double) -> TimeseriesforecastdeeparFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparFrame::min(self : TimeseriesforecastdeeparFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparFrame::max(self : TimeseriesforecastdeeparFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparFrame::to_string(self : TimeseriesforecastdeeparFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_table_make(size : Int) -> TimeseriesforecastdeeparTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparTable::len(self : TimeseriesforecastdeeparTable) -> Int { self.size }

pub fn TimeseriesforecastdeeparTable::get(self : TimeseriesforecastdeeparTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparTable::set(self : TimeseriesforecastdeeparTable, i : Int, v : Double) -> TimeseriesforecastdeeparTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparTable::sum(self : TimeseriesforecastdeeparTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparTable::mean(self : TimeseriesforecastdeeparTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparTable::scale(self : TimeseriesforecastdeeparTable, f : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparTable::add(self : TimeseriesforecastdeeparTable, other : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparTable::copy(self : TimeseriesforecastdeeparTable) -> TimeseriesforecastdeeparTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparTable::fill(self : TimeseriesforecastdeeparTable, v : Double) -> TimeseriesforecastdeeparTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparTable::min(self : TimeseriesforecastdeeparTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparTable::max(self : TimeseriesforecastdeeparTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparTable::to_string(self : TimeseriesforecastdeeparTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_graphn_make(size : Int) -> TimeseriesforecastdeeparGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparGraphN::len(self : TimeseriesforecastdeeparGraphN) -> Int { self.size }

pub fn TimeseriesforecastdeeparGraphN::get(self : TimeseriesforecastdeeparGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparGraphN::set(self : TimeseriesforecastdeeparGraphN, i : Int, v : Double) -> TimeseriesforecastdeeparGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparGraphN::sum(self : TimeseriesforecastdeeparGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparGraphN::mean(self : TimeseriesforecastdeeparGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparGraphN::scale(self : TimeseriesforecastdeeparGraphN, f : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparGraphN::add(self : TimeseriesforecastdeeparGraphN, other : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparGraphN::copy(self : TimeseriesforecastdeeparGraphN) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparGraphN::fill(self : TimeseriesforecastdeeparGraphN, v : Double) -> TimeseriesforecastdeeparGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparGraphN::min(self : TimeseriesforecastdeeparGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparGraphN::max(self : TimeseriesforecastdeeparGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparGraphN::to_string(self : TimeseriesforecastdeeparGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_node_make(size : Int) -> TimeseriesforecastdeeparNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparNode::len(self : TimeseriesforecastdeeparNode) -> Int { self.size }

pub fn TimeseriesforecastdeeparNode::get(self : TimeseriesforecastdeeparNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparNode::set(self : TimeseriesforecastdeeparNode, i : Int, v : Double) -> TimeseriesforecastdeeparNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparNode::sum(self : TimeseriesforecastdeeparNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparNode::mean(self : TimeseriesforecastdeeparNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparNode::scale(self : TimeseriesforecastdeeparNode, f : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparNode::add(self : TimeseriesforecastdeeparNode, other : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparNode::copy(self : TimeseriesforecastdeeparNode) -> TimeseriesforecastdeeparNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparNode::fill(self : TimeseriesforecastdeeparNode, v : Double) -> TimeseriesforecastdeeparNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparNode::min(self : TimeseriesforecastdeeparNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparNode::max(self : TimeseriesforecastdeeparNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparNode::to_string(self : TimeseriesforecastdeeparNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_edge_make(size : Int) -> TimeseriesforecastdeeparEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparEdge::len(self : TimeseriesforecastdeeparEdge) -> Int { self.size }

pub fn TimeseriesforecastdeeparEdge::get(self : TimeseriesforecastdeeparEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparEdge::set(self : TimeseriesforecastdeeparEdge, i : Int, v : Double) -> TimeseriesforecastdeeparEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparEdge::sum(self : TimeseriesforecastdeeparEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparEdge::mean(self : TimeseriesforecastdeeparEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparEdge::scale(self : TimeseriesforecastdeeparEdge, f : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparEdge::add(self : TimeseriesforecastdeeparEdge, other : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparEdge::copy(self : TimeseriesforecastdeeparEdge) -> TimeseriesforecastdeeparEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparEdge::fill(self : TimeseriesforecastdeeparEdge, v : Double) -> TimeseriesforecastdeeparEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparEdge::min(self : TimeseriesforecastdeeparEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparEdge::max(self : TimeseriesforecastdeeparEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparEdge::to_string(self : TimeseriesforecastdeeparEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_path_make(size : Int) -> TimeseriesforecastdeeparPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparPath::len(self : TimeseriesforecastdeeparPath) -> Int { self.size }

pub fn TimeseriesforecastdeeparPath::get(self : TimeseriesforecastdeeparPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparPath::set(self : TimeseriesforecastdeeparPath, i : Int, v : Double) -> TimeseriesforecastdeeparPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparPath::sum(self : TimeseriesforecastdeeparPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparPath::mean(self : TimeseriesforecastdeeparPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparPath::scale(self : TimeseriesforecastdeeparPath, f : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparPath::add(self : TimeseriesforecastdeeparPath, other : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparPath::copy(self : TimeseriesforecastdeeparPath) -> TimeseriesforecastdeeparPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparPath::fill(self : TimeseriesforecastdeeparPath, v : Double) -> TimeseriesforecastdeeparPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparPath::min(self : TimeseriesforecastdeeparPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparPath::max(self : TimeseriesforecastdeeparPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparPath::to_string(self : TimeseriesforecastdeeparPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cluster_make(size : Int) -> TimeseriesforecastdeeparCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparCluster::len(self : TimeseriesforecastdeeparCluster) -> Int { self.size }

pub fn TimeseriesforecastdeeparCluster::get(self : TimeseriesforecastdeeparCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparCluster::set(self : TimeseriesforecastdeeparCluster, i : Int, v : Double) -> TimeseriesforecastdeeparCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCluster::sum(self : TimeseriesforecastdeeparCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparCluster::mean(self : TimeseriesforecastdeeparCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparCluster::scale(self : TimeseriesforecastdeeparCluster, f : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCluster::add(self : TimeseriesforecastdeeparCluster, other : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCluster::copy(self : TimeseriesforecastdeeparCluster) -> TimeseriesforecastdeeparCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCluster::fill(self : TimeseriesforecastdeeparCluster, v : Double) -> TimeseriesforecastdeeparCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCluster::min(self : TimeseriesforecastdeeparCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparCluster::max(self : TimeseriesforecastdeeparCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparCluster::to_string(self : TimeseriesforecastdeeparCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_model_make(size : Int) -> TimeseriesforecastdeeparModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparModel::len(self : TimeseriesforecastdeeparModel) -> Int { self.size }

pub fn TimeseriesforecastdeeparModel::get(self : TimeseriesforecastdeeparModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparModel::set(self : TimeseriesforecastdeeparModel, i : Int, v : Double) -> TimeseriesforecastdeeparModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparModel::sum(self : TimeseriesforecastdeeparModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparModel::mean(self : TimeseriesforecastdeeparModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparModel::scale(self : TimeseriesforecastdeeparModel, f : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparModel::add(self : TimeseriesforecastdeeparModel, other : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparModel::copy(self : TimeseriesforecastdeeparModel) -> TimeseriesforecastdeeparModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparModel::fill(self : TimeseriesforecastdeeparModel, v : Double) -> TimeseriesforecastdeeparModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparModel::min(self : TimeseriesforecastdeeparModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparModel::max(self : TimeseriesforecastdeeparModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparModel::to_string(self : TimeseriesforecastdeeparModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_layer_make(size : Int) -> TimeseriesforecastdeeparLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparLayer::len(self : TimeseriesforecastdeeparLayer) -> Int { self.size }

pub fn TimeseriesforecastdeeparLayer::get(self : TimeseriesforecastdeeparLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparLayer::set(self : TimeseriesforecastdeeparLayer, i : Int, v : Double) -> TimeseriesforecastdeeparLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparLayer::sum(self : TimeseriesforecastdeeparLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparLayer::mean(self : TimeseriesforecastdeeparLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparLayer::scale(self : TimeseriesforecastdeeparLayer, f : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparLayer::add(self : TimeseriesforecastdeeparLayer, other : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparLayer::copy(self : TimeseriesforecastdeeparLayer) -> TimeseriesforecastdeeparLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparLayer::fill(self : TimeseriesforecastdeeparLayer, v : Double) -> TimeseriesforecastdeeparLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparLayer::min(self : TimeseriesforecastdeeparLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparLayer::max(self : TimeseriesforecastdeeparLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparLayer::to_string(self : TimeseriesforecastdeeparLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_buffer_make(size : Int) -> TimeseriesforecastdeeparBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparBuffer::len(self : TimeseriesforecastdeeparBuffer) -> Int { self.size }

pub fn TimeseriesforecastdeeparBuffer::get(self : TimeseriesforecastdeeparBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparBuffer::set(self : TimeseriesforecastdeeparBuffer, i : Int, v : Double) -> TimeseriesforecastdeeparBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparBuffer::sum(self : TimeseriesforecastdeeparBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparBuffer::mean(self : TimeseriesforecastdeeparBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparBuffer::scale(self : TimeseriesforecastdeeparBuffer, f : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparBuffer::add(self : TimeseriesforecastdeeparBuffer, other : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparBuffer::copy(self : TimeseriesforecastdeeparBuffer) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparBuffer::fill(self : TimeseriesforecastdeeparBuffer, v : Double) -> TimeseriesforecastdeeparBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparBuffer::min(self : TimeseriesforecastdeeparBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparBuffer::max(self : TimeseriesforecastdeeparBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparBuffer::to_string(self : TimeseriesforecastdeeparBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_cursor_make(size : Int) -> TimeseriesforecastdeeparCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparCursor::len(self : TimeseriesforecastdeeparCursor) -> Int { self.size }

pub fn TimeseriesforecastdeeparCursor::get(self : TimeseriesforecastdeeparCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparCursor::set(self : TimeseriesforecastdeeparCursor, i : Int, v : Double) -> TimeseriesforecastdeeparCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCursor::sum(self : TimeseriesforecastdeeparCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparCursor::mean(self : TimeseriesforecastdeeparCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparCursor::scale(self : TimeseriesforecastdeeparCursor, f : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCursor::add(self : TimeseriesforecastdeeparCursor, other : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCursor::copy(self : TimeseriesforecastdeeparCursor) -> TimeseriesforecastdeeparCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCursor::fill(self : TimeseriesforecastdeeparCursor, v : Double) -> TimeseriesforecastdeeparCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparCursor::min(self : TimeseriesforecastdeeparCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparCursor::max(self : TimeseriesforecastdeeparCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparCursor::to_string(self : TimeseriesforecastdeeparCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_view_make(size : Int) -> TimeseriesforecastdeeparView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparView::len(self : TimeseriesforecastdeeparView) -> Int { self.size }

pub fn TimeseriesforecastdeeparView::get(self : TimeseriesforecastdeeparView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparView::set(self : TimeseriesforecastdeeparView, i : Int, v : Double) -> TimeseriesforecastdeeparView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparView::sum(self : TimeseriesforecastdeeparView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparView::mean(self : TimeseriesforecastdeeparView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparView::scale(self : TimeseriesforecastdeeparView, f : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparView::add(self : TimeseriesforecastdeeparView, other : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparView::copy(self : TimeseriesforecastdeeparView) -> TimeseriesforecastdeeparView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparView::fill(self : TimeseriesforecastdeeparView, v : Double) -> TimeseriesforecastdeeparView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparView::min(self : TimeseriesforecastdeeparView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparView::max(self : TimeseriesforecastdeeparView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparView::to_string(self : TimeseriesforecastdeeparView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_range_make(size : Int) -> TimeseriesforecastdeeparRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparRange::len(self : TimeseriesforecastdeeparRange) -> Int { self.size }

pub fn TimeseriesforecastdeeparRange::get(self : TimeseriesforecastdeeparRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparRange::set(self : TimeseriesforecastdeeparRange, i : Int, v : Double) -> TimeseriesforecastdeeparRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparRange::sum(self : TimeseriesforecastdeeparRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparRange::mean(self : TimeseriesforecastdeeparRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparRange::scale(self : TimeseriesforecastdeeparRange, f : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparRange::add(self : TimeseriesforecastdeeparRange, other : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparRange::copy(self : TimeseriesforecastdeeparRange) -> TimeseriesforecastdeeparRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparRange::fill(self : TimeseriesforecastdeeparRange, v : Double) -> TimeseriesforecastdeeparRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparRange::min(self : TimeseriesforecastdeeparRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparRange::max(self : TimeseriesforecastdeeparRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparRange::to_string(self : TimeseriesforecastdeeparRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdeeparSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_deepar_slice_make(size : Int) -> TimeseriesforecastdeeparSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdeeparSlice::len(self : TimeseriesforecastdeeparSlice) -> Int { self.size }

pub fn TimeseriesforecastdeeparSlice::get(self : TimeseriesforecastdeeparSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdeeparSlice::set(self : TimeseriesforecastdeeparSlice, i : Int, v : Double) -> TimeseriesforecastdeeparSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparSlice::sum(self : TimeseriesforecastdeeparSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdeeparSlice::mean(self : TimeseriesforecastdeeparSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdeeparSlice::scale(self : TimeseriesforecastdeeparSlice, f : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparSlice::add(self : TimeseriesforecastdeeparSlice, other : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdeeparSlice::copy(self : TimeseriesforecastdeeparSlice) -> TimeseriesforecastdeeparSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparSlice::fill(self : TimeseriesforecastdeeparSlice, v : Double) -> TimeseriesforecastdeeparSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdeeparSlice::min(self : TimeseriesforecastdeeparSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdeeparSlice::max(self : TimeseriesforecastdeeparSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdeeparSlice::to_string(self : TimeseriesforecastdeeparSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

