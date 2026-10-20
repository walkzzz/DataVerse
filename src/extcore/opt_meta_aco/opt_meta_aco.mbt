///===
/// extcore/opt_meta_aco

pub(all) struct OptmetaacoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_aco_make_point(x : Double, y : Double) -> OptmetaacoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_aco_make_point3(x : Double, y : Double, z : Double) -> OptmetaacoPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetaacoPoint::x(self : OptmetaacoPoint) -> Double { self.x }

pub fn OptmetaacoPoint::y(self : OptmetaacoPoint) -> Double { self.y }

pub fn OptmetaacoPoint::z(self : OptmetaacoPoint) -> Double { self.z }

pub fn OptmetaacoPoint::label(self : OptmetaacoPoint) -> Int { self.label }

pub fn OptmetaacoPoint::dist(self : OptmetaacoPoint, other : OptmetaacoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetaacoPoint::add(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetaacoPoint::sub(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetaacoPoint::scale(self : OptmetaacoPoint, s : Double) -> OptmetaacoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetaacoPoint::dot(self : OptmetaacoPoint, other : OptmetaacoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetaacoPoint::cross(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetaacoPoint::norm(self : OptmetaacoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetaacoPoint::normalize(self : OptmetaacoPoint) -> OptmetaacoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaacoPoint::negate(self : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetaacoPoint::mid(self : OptmetaacoPoint, other : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetaacoPoint::lerp(self : OptmetaacoPoint, other : OptmetaacoPoint, t : Double) -> OptmetaacoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetaacoPoint::to_string(self : OptmetaacoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetaacoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_aco_make_series(vals : Array[Double], name : String) -> OptmetaacoSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetaacoSeries::len(self : OptmetaacoSeries) -> Int { self.vals.length() }

pub fn OptmetaacoSeries::sum(self : OptmetaacoSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetaacoSeries::mean(self : OptmetaacoSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetaacoSeries::min(self : OptmetaacoSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetaacoSeries::max(self : OptmetaacoSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetaacoSeries::range(self : OptmetaacoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetaacoSeries::variance(self : OptmetaacoSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetaacoSeries::std(self : OptmetaacoSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetaacoSeries::median(self : OptmetaacoSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetaacoSeries::scale(self : OptmetaacoSeries, f : Double) -> OptmetaacoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetaacoSeries::add(self : OptmetaacoSeries, other : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetaacoSeries::sub(self : OptmetaacoSeries, other : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetaacoSeries::normalize(self : OptmetaacoSeries) -> OptmetaacoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetaacoSeries::cumsum(self : OptmetaacoSeries) -> OptmetaacoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetaacoSeries::to_string(self : OptmetaacoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaacoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_aco_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaacoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_aco_matrix_identity(n : Int) -> OptmetaacoMatrix {
  let m = opt_meta_aco_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetaacoMatrix::get(self : OptmetaacoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetaacoMatrix::transpose(self : OptmetaacoMatrix) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetaacoMatrix::add(self : OptmetaacoMatrix, other : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_aco_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetaacoMatrix::scale(self : OptmetaacoMatrix, s : Double) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetaacoMatrix::multiply(self : OptmetaacoMatrix, other : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if self.cols != other.rows { return opt_meta_aco_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_aco_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptmetaacoMatrix::trace(self : OptmetaacoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetaacoMatrix::det(self : OptmetaacoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetaacoMatrix::norm(self : OptmetaacoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetaacoMatrix::to_string(self : OptmetaacoMatrix) -> String {
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

pub(all) struct OptmetaacoVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_aco_make_vector(comps : Array[Double]) -> OptmetaacoVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_aco_vector_zero(dim : Int) -> OptmetaacoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetaacoVector::add(self : OptmetaacoVector, other : OptmetaacoVector) -> OptmetaacoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaacoVector::sub(self : OptmetaacoVector, other : OptmetaacoVector) -> OptmetaacoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetaacoVector::scale(self : OptmetaacoVector, s : Double) -> OptmetaacoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetaacoVector::dot(self : OptmetaacoVector, other : OptmetaacoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetaacoVector::norm(self : OptmetaacoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetaacoVector::normalize(self : OptmetaacoVector) -> OptmetaacoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetaacoVector::dist(self : OptmetaacoVector, other : OptmetaacoVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetaacoVector::to_string(self : OptmetaacoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaacoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_frame_make(size : Int) -> OptmetaacoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoFrame::len(self : OptmetaacoFrame) -> Int { self.size }

pub fn OptmetaacoFrame::get(self : OptmetaacoFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoFrame::set(self : OptmetaacoFrame, i : Int, v : Double) -> OptmetaacoFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoFrame::sum(self : OptmetaacoFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoFrame::mean(self : OptmetaacoFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoFrame::scale(self : OptmetaacoFrame, f : Double) -> OptmetaacoFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoFrame::add(self : OptmetaacoFrame, other : OptmetaacoFrame) -> OptmetaacoFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoFrame::copy(self : OptmetaacoFrame) -> OptmetaacoFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoFrame::fill(self : OptmetaacoFrame, v : Double) -> OptmetaacoFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoFrame::min(self : OptmetaacoFrame) -> Double { @_common.min(self.data) }

pub fn OptmetaacoFrame::max(self : OptmetaacoFrame) -> Double { @_common.max(self.data) }

pub fn OptmetaacoFrame::to_string(self : OptmetaacoFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_table_make(size : Int) -> OptmetaacoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoTable::len(self : OptmetaacoTable) -> Int { self.size }

pub fn OptmetaacoTable::get(self : OptmetaacoTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoTable::set(self : OptmetaacoTable, i : Int, v : Double) -> OptmetaacoTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoTable::sum(self : OptmetaacoTable) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoTable::mean(self : OptmetaacoTable) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoTable::scale(self : OptmetaacoTable, f : Double) -> OptmetaacoTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoTable::add(self : OptmetaacoTable, other : OptmetaacoTable) -> OptmetaacoTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoTable::copy(self : OptmetaacoTable) -> OptmetaacoTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoTable::fill(self : OptmetaacoTable, v : Double) -> OptmetaacoTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoTable::min(self : OptmetaacoTable) -> Double { @_common.min(self.data) }

pub fn OptmetaacoTable::max(self : OptmetaacoTable) -> Double { @_common.max(self.data) }

pub fn OptmetaacoTable::to_string(self : OptmetaacoTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_graphn_make(size : Int) -> OptmetaacoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoGraphN::len(self : OptmetaacoGraphN) -> Int { self.size }

pub fn OptmetaacoGraphN::get(self : OptmetaacoGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoGraphN::set(self : OptmetaacoGraphN, i : Int, v : Double) -> OptmetaacoGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoGraphN::sum(self : OptmetaacoGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoGraphN::mean(self : OptmetaacoGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoGraphN::scale(self : OptmetaacoGraphN, f : Double) -> OptmetaacoGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoGraphN::add(self : OptmetaacoGraphN, other : OptmetaacoGraphN) -> OptmetaacoGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoGraphN::copy(self : OptmetaacoGraphN) -> OptmetaacoGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoGraphN::fill(self : OptmetaacoGraphN, v : Double) -> OptmetaacoGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoGraphN::min(self : OptmetaacoGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetaacoGraphN::max(self : OptmetaacoGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetaacoGraphN::to_string(self : OptmetaacoGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_node_make(size : Int) -> OptmetaacoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoNode::len(self : OptmetaacoNode) -> Int { self.size }

pub fn OptmetaacoNode::get(self : OptmetaacoNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoNode::set(self : OptmetaacoNode, i : Int, v : Double) -> OptmetaacoNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoNode::sum(self : OptmetaacoNode) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoNode::mean(self : OptmetaacoNode) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoNode::scale(self : OptmetaacoNode, f : Double) -> OptmetaacoNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoNode::add(self : OptmetaacoNode, other : OptmetaacoNode) -> OptmetaacoNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoNode::copy(self : OptmetaacoNode) -> OptmetaacoNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoNode::fill(self : OptmetaacoNode, v : Double) -> OptmetaacoNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoNode::min(self : OptmetaacoNode) -> Double { @_common.min(self.data) }

pub fn OptmetaacoNode::max(self : OptmetaacoNode) -> Double { @_common.max(self.data) }

pub fn OptmetaacoNode::to_string(self : OptmetaacoNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_edge_make(size : Int) -> OptmetaacoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoEdge::len(self : OptmetaacoEdge) -> Int { self.size }

pub fn OptmetaacoEdge::get(self : OptmetaacoEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoEdge::set(self : OptmetaacoEdge, i : Int, v : Double) -> OptmetaacoEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoEdge::sum(self : OptmetaacoEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoEdge::mean(self : OptmetaacoEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoEdge::scale(self : OptmetaacoEdge, f : Double) -> OptmetaacoEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoEdge::add(self : OptmetaacoEdge, other : OptmetaacoEdge) -> OptmetaacoEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoEdge::copy(self : OptmetaacoEdge) -> OptmetaacoEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoEdge::fill(self : OptmetaacoEdge, v : Double) -> OptmetaacoEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoEdge::min(self : OptmetaacoEdge) -> Double { @_common.min(self.data) }

pub fn OptmetaacoEdge::max(self : OptmetaacoEdge) -> Double { @_common.max(self.data) }

pub fn OptmetaacoEdge::to_string(self : OptmetaacoEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_path_make(size : Int) -> OptmetaacoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoPath::len(self : OptmetaacoPath) -> Int { self.size }

pub fn OptmetaacoPath::get(self : OptmetaacoPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoPath::set(self : OptmetaacoPath, i : Int, v : Double) -> OptmetaacoPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoPath::sum(self : OptmetaacoPath) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoPath::mean(self : OptmetaacoPath) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoPath::scale(self : OptmetaacoPath, f : Double) -> OptmetaacoPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoPath::add(self : OptmetaacoPath, other : OptmetaacoPath) -> OptmetaacoPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoPath::copy(self : OptmetaacoPath) -> OptmetaacoPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoPath::fill(self : OptmetaacoPath, v : Double) -> OptmetaacoPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoPath::min(self : OptmetaacoPath) -> Double { @_common.min(self.data) }

pub fn OptmetaacoPath::max(self : OptmetaacoPath) -> Double { @_common.max(self.data) }

pub fn OptmetaacoPath::to_string(self : OptmetaacoPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cluster_make(size : Int) -> OptmetaacoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoCluster::len(self : OptmetaacoCluster) -> Int { self.size }

pub fn OptmetaacoCluster::get(self : OptmetaacoCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoCluster::set(self : OptmetaacoCluster, i : Int, v : Double) -> OptmetaacoCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoCluster::sum(self : OptmetaacoCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoCluster::mean(self : OptmetaacoCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoCluster::scale(self : OptmetaacoCluster, f : Double) -> OptmetaacoCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCluster::add(self : OptmetaacoCluster, other : OptmetaacoCluster) -> OptmetaacoCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoCluster::copy(self : OptmetaacoCluster) -> OptmetaacoCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCluster::fill(self : OptmetaacoCluster, v : Double) -> OptmetaacoCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCluster::min(self : OptmetaacoCluster) -> Double { @_common.min(self.data) }

pub fn OptmetaacoCluster::max(self : OptmetaacoCluster) -> Double { @_common.max(self.data) }

pub fn OptmetaacoCluster::to_string(self : OptmetaacoCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_model_make(size : Int) -> OptmetaacoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoModel::len(self : OptmetaacoModel) -> Int { self.size }

pub fn OptmetaacoModel::get(self : OptmetaacoModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoModel::set(self : OptmetaacoModel, i : Int, v : Double) -> OptmetaacoModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoModel::sum(self : OptmetaacoModel) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoModel::mean(self : OptmetaacoModel) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoModel::scale(self : OptmetaacoModel, f : Double) -> OptmetaacoModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoModel::add(self : OptmetaacoModel, other : OptmetaacoModel) -> OptmetaacoModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoModel::copy(self : OptmetaacoModel) -> OptmetaacoModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoModel::fill(self : OptmetaacoModel, v : Double) -> OptmetaacoModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoModel::min(self : OptmetaacoModel) -> Double { @_common.min(self.data) }

pub fn OptmetaacoModel::max(self : OptmetaacoModel) -> Double { @_common.max(self.data) }

pub fn OptmetaacoModel::to_string(self : OptmetaacoModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_layer_make(size : Int) -> OptmetaacoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoLayer::len(self : OptmetaacoLayer) -> Int { self.size }

pub fn OptmetaacoLayer::get(self : OptmetaacoLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoLayer::set(self : OptmetaacoLayer, i : Int, v : Double) -> OptmetaacoLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoLayer::sum(self : OptmetaacoLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoLayer::mean(self : OptmetaacoLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoLayer::scale(self : OptmetaacoLayer, f : Double) -> OptmetaacoLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoLayer::add(self : OptmetaacoLayer, other : OptmetaacoLayer) -> OptmetaacoLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoLayer::copy(self : OptmetaacoLayer) -> OptmetaacoLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoLayer::fill(self : OptmetaacoLayer, v : Double) -> OptmetaacoLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoLayer::min(self : OptmetaacoLayer) -> Double { @_common.min(self.data) }

pub fn OptmetaacoLayer::max(self : OptmetaacoLayer) -> Double { @_common.max(self.data) }

pub fn OptmetaacoLayer::to_string(self : OptmetaacoLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_buffer_make(size : Int) -> OptmetaacoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoBuffer::len(self : OptmetaacoBuffer) -> Int { self.size }

pub fn OptmetaacoBuffer::get(self : OptmetaacoBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoBuffer::set(self : OptmetaacoBuffer, i : Int, v : Double) -> OptmetaacoBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoBuffer::sum(self : OptmetaacoBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoBuffer::mean(self : OptmetaacoBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoBuffer::scale(self : OptmetaacoBuffer, f : Double) -> OptmetaacoBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoBuffer::add(self : OptmetaacoBuffer, other : OptmetaacoBuffer) -> OptmetaacoBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoBuffer::copy(self : OptmetaacoBuffer) -> OptmetaacoBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoBuffer::fill(self : OptmetaacoBuffer, v : Double) -> OptmetaacoBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoBuffer::min(self : OptmetaacoBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetaacoBuffer::max(self : OptmetaacoBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetaacoBuffer::to_string(self : OptmetaacoBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cursor_make(size : Int) -> OptmetaacoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoCursor::len(self : OptmetaacoCursor) -> Int { self.size }

pub fn OptmetaacoCursor::get(self : OptmetaacoCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoCursor::set(self : OptmetaacoCursor, i : Int, v : Double) -> OptmetaacoCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoCursor::sum(self : OptmetaacoCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoCursor::mean(self : OptmetaacoCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoCursor::scale(self : OptmetaacoCursor, f : Double) -> OptmetaacoCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCursor::add(self : OptmetaacoCursor, other : OptmetaacoCursor) -> OptmetaacoCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoCursor::copy(self : OptmetaacoCursor) -> OptmetaacoCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCursor::fill(self : OptmetaacoCursor, v : Double) -> OptmetaacoCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoCursor::min(self : OptmetaacoCursor) -> Double { @_common.min(self.data) }

pub fn OptmetaacoCursor::max(self : OptmetaacoCursor) -> Double { @_common.max(self.data) }

pub fn OptmetaacoCursor::to_string(self : OptmetaacoCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_view_make(size : Int) -> OptmetaacoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoView::len(self : OptmetaacoView) -> Int { self.size }

pub fn OptmetaacoView::get(self : OptmetaacoView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoView::set(self : OptmetaacoView, i : Int, v : Double) -> OptmetaacoView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoView::sum(self : OptmetaacoView) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoView::mean(self : OptmetaacoView) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoView::scale(self : OptmetaacoView, f : Double) -> OptmetaacoView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoView::add(self : OptmetaacoView, other : OptmetaacoView) -> OptmetaacoView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoView::copy(self : OptmetaacoView) -> OptmetaacoView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoView::fill(self : OptmetaacoView, v : Double) -> OptmetaacoView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoView::min(self : OptmetaacoView) -> Double { @_common.min(self.data) }

pub fn OptmetaacoView::max(self : OptmetaacoView) -> Double { @_common.max(self.data) }

pub fn OptmetaacoView::to_string(self : OptmetaacoView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_range_make(size : Int) -> OptmetaacoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoRange::len(self : OptmetaacoRange) -> Int { self.size }

pub fn OptmetaacoRange::get(self : OptmetaacoRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoRange::set(self : OptmetaacoRange, i : Int, v : Double) -> OptmetaacoRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoRange::sum(self : OptmetaacoRange) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoRange::mean(self : OptmetaacoRange) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoRange::scale(self : OptmetaacoRange, f : Double) -> OptmetaacoRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoRange::add(self : OptmetaacoRange, other : OptmetaacoRange) -> OptmetaacoRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoRange::copy(self : OptmetaacoRange) -> OptmetaacoRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoRange::fill(self : OptmetaacoRange, v : Double) -> OptmetaacoRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoRange::min(self : OptmetaacoRange) -> Double { @_common.min(self.data) }

pub fn OptmetaacoRange::max(self : OptmetaacoRange) -> Double { @_common.max(self.data) }

pub fn OptmetaacoRange::to_string(self : OptmetaacoRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetaacoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_slice_make(size : Int) -> OptmetaacoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetaacoSlice::len(self : OptmetaacoSlice) -> Int { self.size }

pub fn OptmetaacoSlice::get(self : OptmetaacoSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetaacoSlice::set(self : OptmetaacoSlice, i : Int, v : Double) -> OptmetaacoSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetaacoSlice::sum(self : OptmetaacoSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetaacoSlice::mean(self : OptmetaacoSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetaacoSlice::scale(self : OptmetaacoSlice, f : Double) -> OptmetaacoSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetaacoSlice::add(self : OptmetaacoSlice, other : OptmetaacoSlice) -> OptmetaacoSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetaacoSlice::copy(self : OptmetaacoSlice) -> OptmetaacoSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetaacoSlice::fill(self : OptmetaacoSlice, v : Double) -> OptmetaacoSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetaacoSlice::min(self : OptmetaacoSlice) -> Double { @_common.min(self.data) }

pub fn OptmetaacoSlice::max(self : OptmetaacoSlice) -> Double { @_common.max(self.data) }

pub fn OptmetaacoSlice::to_string(self : OptmetaacoSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

